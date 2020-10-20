Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976F528D470
	for <lists+linux-block@lfdr.de>; Tue, 13 Oct 2020 21:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732644AbgJMT0D (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 13 Oct 2020 15:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732643AbgJMT0C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Oct 2020 15:26:02 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8B7C0613D0
        for <linux-block@vger.kernel.org>; Tue, 13 Oct 2020 12:26:02 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id r10so292675pgb.10
        for <linux-block@vger.kernel.org>; Tue, 13 Oct 2020 12:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=af4Qc+2gHzFlWubHHxJx9BBa7rTwjknQssJBJD0vteA=;
        b=SngYSO1WqQoNuEy3IfUOgUXEi3oLu0pp1rkBq5PYTTvQ5nlqeRR65jWwAHAb/l9TGu
         aNri5fZdMjxBOHgTwV/H05fSeagl2qKt8dAe8Y2uHeT5fmujXFKVcTUD/eL4E64bHF5g
         RB6E/tqEV0SXdYQ4epJDVpzEPILi/CkW3lnTSuAFEF8RjTbiMn8YiKy3gBNH3c9Edco8
         SumaPILetIQSpl4FZoM2H4HHQcusKVMeHZU+0cOq0yzwDq7mYfTGjC4NDd+tj2e5g5wH
         mdsBs6DxMGwrMRGWKq/AtkieSfhvuhpt8z2midqt8p2Tq7w/uyBmRM+2TBxM4IfZWwzd
         LvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=af4Qc+2gHzFlWubHHxJx9BBa7rTwjknQssJBJD0vteA=;
        b=r1XUMIYmZ0AzvR25yDMIIMnof/Zx9sHjZo/o1/c57vXqD19137NPNNY/Z3lBJ5zvbg
         SDRfyx0N7sGdd6IirgVC+y8UvRl1yTcRsV8+7+mSPOgAk5T9IaJjSukYM/JqWFkiWfko
         nv/ojPKNzcy1oJsPQLaKP7Js/7Akd1JOyyP37PNOEyEjexvsmZgMR1n7k6dvRx53qbdT
         tutjparGRaiwBtCCFXxleoiU8f5kbXaEC8CUWjtaE4K4If/0dMdCBTkUsKAvOur2sscD
         VTlAMLDlY4ono39AaoBBP6w/RjyVl+aJl29QgAqmNSuCJ7f17y0vjAs8ZpmP0leja8cI
         XVzg==
X-Gm-Message-State: AOAM533IZaCkuqVELVrmo/jZ4b0JaFRh4vB7IGx1+IC4XZ377LZ4aK1l
        Qc0USEE9Vr5n132W4img8IPUrg==
X-Google-Smtp-Source: ABdhPJyjxaWb7RHMI6pGEY7tNUS7TTgfXPifUmnKryBF4E2RBCFrtRlq2i1ygbicehU2F6J0EqLWLw==
X-Received: by 2002:a63:1f03:: with SMTP id f3mr817329pgf.381.1602617161620;
        Tue, 13 Oct 2020 12:26:01 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id z20sm451263pfn.39.2020.10.13.12.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 12:26:01 -0700 (PDT)
Subject: Re: [PATCHv4 1/3] block: add zone specific block statuses
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, hch@lst.de, linux-api@vger.kernel.org,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20200924205330.4043232-1-kbusch@kernel.org>
 <20200924205330.4043232-2-kbusch@kernel.org>
 <20201009152927.GA1023921@dhcp-10-100-145-180.wdl.wdc.com>
 <20201013171610.GB1033288@dhcp-10-100-145-180.wdl.wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <52669c98-ddc3-188e-ee2b-aff1823e8e96@kernel.dk>
Date:   Tue, 13 Oct 2020 13:25:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201013171610.GB1033288@dhcp-10-100-145-180.wdl.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/13/20 11:16 AM, Keith Busch wrote:
> Hi Jens,
> 
> I'm going to try one more time in the hope you've just been too busy to
> notice these patches. The series has been unchanged for a month now, and
> has reviews from all the right people. Can this be considered for
> inclusion?

Thanks for the pings, finally got them picked up. Sorry about the
delay!

-- 
Jens Axboe

