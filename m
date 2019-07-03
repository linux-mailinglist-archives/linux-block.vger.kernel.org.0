Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B865A5DCC3
	for <lists+linux-block@lfdr.de>; Wed,  3 Jul 2019 05:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfGCDJM (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 2 Jul 2019 23:09:12 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37674 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbfGCDJM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Jul 2019 23:09:12 -0400
Received: by mail-pg1-f196.google.com with SMTP id g15so413495pgi.4
        for <linux-block@vger.kernel.org>; Tue, 02 Jul 2019 20:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=njcg6GhHzmb45hB8haSoWP6JjVmUOT/q7oT/Ma/G3Lg=;
        b=lPo54HpZEJLoLfNFc0/dPbtcpZc8h8VZf3sBcaCjkLRuBGyFQ2HZZ80HW63uMxTPKU
         gwzu9G9S5/y22LHsIvw1MZ4hafGdASh/Zz44p91rVWiCBQez4XqR4fYp69fWpv60yfpU
         w5adA1bFIS34T5DmomgD32AkjhC6/w0jvO10Tjqlc7P/tjjHkc8T9exFM2FQuxneV2wN
         8bYvWokwNh9N3qLWEcK3zDQC8vu0NRMPBgnEFTavKFaG0rYwahGXsvXALHRpykmbKHjH
         FfkqhHyYp5heRXGBWSsHBFG/UYe21WpFgFRJA/3MBO8xwpH1WNsCbE1rwyZtizdkEZAV
         l4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=njcg6GhHzmb45hB8haSoWP6JjVmUOT/q7oT/Ma/G3Lg=;
        b=LYhRuKIrfHmuLS8A1oBLPihmatlFaY7Z/N9jzqwaJVniHK/zB3eEBZNr/t3lCFuTcR
         z/ktsak5sOXYbmJX2HelWernU2XEoev1M09fWbiHQMUl5MmImD/0cfZroGFO8mjA8cru
         9IcBhX85h4jz3yxszK48StYp2NkQI0+dYxtd6ylBWEbIh48m4pLeom31qQzWMrVeTq9o
         m3Ijd3+Q4J0ZbCz3qcXr83mNbsvIx8Y/A9aNv9j3mHrGTC4iZX3V1HXjh8ZDCljAYaBL
         MAF6NHSX8RrzZ/fOYuPJMfbxPxd6twmRPVMe7jIrahmbQAY7Ka+VS4ff6UIODVDgQKI9
         yXKw==
X-Gm-Message-State: APjAAAXiXvHLkoALgzemSRNn7/nhvCi2tBVFHCYFYtz/iVjC+COJRUP9
        IiGDtYWLGIYqlhPGlCdkoNw=
X-Google-Smtp-Source: APXvYqxGRknxodgL0Td1hAjbHSIVYKwYSolyw3WXaIVBOrvKZV6csXY4Z+WwzfmGcOny0ONBi9EWJQ==
X-Received: by 2002:a63:4f07:: with SMTP id d7mr33278982pgb.77.1562123351270;
        Tue, 02 Jul 2019 20:09:11 -0700 (PDT)
Received: from continental ([189.58.144.164])
        by smtp.gmail.com with ESMTPSA id t32sm501177pgk.29.2019.07.02.20.09.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 20:09:10 -0700 (PDT)
Date:   Wed, 3 Jul 2019 00:09:55 -0300
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH] null_blk: use SECTOR_SHIFT consistently
Message-ID: <20190703030955.GA11462@continental>
References: <20190702202857.4433-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702202857.4433-1-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 02, 2019 at 01:28:57PM -0700, Chaitanya Kulkarni wrote:
> This is a pure cleanup patch and doesn't change any functionality.
> In null_blk_main.c we use mixed style of the code SECTOR_SHIFT and
> >> 9. Get rid of the >> 9 and use SECTOR_SHIFT everywhere.
> 

Agreed, much better than a magic number.

Acked-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
