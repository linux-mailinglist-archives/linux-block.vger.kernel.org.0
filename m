Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAD0FD000
	for <lists+linux-block@lfdr.de>; Thu, 14 Nov 2019 22:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfKNVAH (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 14 Nov 2019 16:00:07 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:37150 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfKNVAG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Nov 2019 16:00:06 -0500
Received: by mail-io1-f68.google.com with SMTP id 1so8439581iou.4
        for <linux-block@vger.kernel.org>; Thu, 14 Nov 2019 13:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2RCRd1zRoSH07b5v7RL4RafxXdTJJZiUPEj/afSVw78=;
        b=YNxH8NbMhwUYGitY/Ab8r0DUqNgvVIm+bEuphpLo4NQUawxmvKxQdtjh5EVC7g05Em
         XU3dcRrNdA9cJKW9th++xAF+ZnMP3PXXJPaPp0bE+jMSC8C2f1TpqM8t4Kx6LkWo7mNi
         HYgOG4woNprQRTUpNR+QbrpPj+7ta6SvBoPF3OBKzJrN1QfjyGx9DCBljki0QcgAQ+tB
         R0T7g6HLXCSOuHLmK+lzgNAZzYTJNIntLSSTJ/JhW+pPj8m5zX9poDn2HBZIif0iTJDL
         N9TV1sUphiHaYpnPzYUrQrB/iuRhFfJRjUuvc/m3huhfkkqhqBXkD1rgQCtDFPziwuEP
         gyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2RCRd1zRoSH07b5v7RL4RafxXdTJJZiUPEj/afSVw78=;
        b=K5COJ01Gzxfj6H8RUxTJwaijhpPpGfFt4jIveHAt4P5mr3pkRFK6yoNAg6n4bjcaeT
         iCwY0QYEeEaLXBHVJ22jSp13tigZGuX8gFbFqN605gDGj4PkUe1sPseLhGXcY9P1HPrc
         tA1+D47Y7VpUe+dZMfUb0NxvMhXm8Px46bWKUe+Yim/VFCBp/R+HuEDwAhp2+0F4wBeK
         o84wR0wWVc0R8YTNopo84QqA/9sSrEClO6gpAYFTCI2AwHtl1EVMYjgXQ8HVF9+OS7we
         zQhrBdcSp651BOrvKdPpzlpFVpMzwzvVHwFwdSdv2F13q+VmKjGDphg47c3S2NBR4fVK
         6fOg==
X-Gm-Message-State: APjAAAXAlqh+DRhd9YKndK9sybjlJzbQbwoHCWbrAdp0kTcyylHU6MEX
        8lY3NBR+BnH8+JWbj69z9vYf5w==
X-Google-Smtp-Source: APXvYqwTnCXgTkvagONxVq1I+5EreygE7ahwByoW7h7MTQrjplHcn1zXO756wXIUf7Ii9eGO864khA==
X-Received: by 2002:a6b:7f03:: with SMTP id l3mr10489243ioq.271.1573765204738;
        Thu, 14 Nov 2019 13:00:04 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id x1sm682137ioh.59.2019.11.14.13.00.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 13:00:03 -0800 (PST)
Subject: Re: [PATCH] rsxx: add missed destroy_workqueue calls in remove
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191113063847.8955-1-hslester96@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cb36f877-f508-ca15-36c0-f4d56651b97f@kernel.dk>
Date:   Thu, 14 Nov 2019 14:00:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113063847.8955-1-hslester96@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/12/19 11:38 PM, Chuhong Yuan wrote:
> The driver misses calling destroy_workqueue in remove like what is done
> when probe fails.
> Add the missed calls to fix it.

Applied, thanks.

-- 
Jens Axboe

