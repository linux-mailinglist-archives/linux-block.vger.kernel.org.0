Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA9629C5F1
	for <lists+linux-block@lfdr.de>; Tue, 27 Oct 2020 19:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1825200AbgJ0SJg (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 27 Oct 2020 14:09:36 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:35122 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1825199AbgJ0SJf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Oct 2020 14:09:35 -0400
Received: by mail-qv1-f65.google.com with SMTP id cv1so1119614qvb.2
        for <linux-block@vger.kernel.org>; Tue, 27 Oct 2020 11:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s6kvyFZCCfeghhHhKElYXyIn1aDbAYI4u2TzXLshK/o=;
        b=zDJJhH9iadOPwvsev+eAa8hXFa8CuZvBNO/pHufUAbjy0CslNZWas1B8QaovaGkNX1
         ffelaXGAhTGKFOO6nGX6iAhABj8n/DYQ8mkL02TY362AnPyCHoSoc1XFPdcnN4yMMTb5
         US3Z924TgGYV5/BFgDopHFeQ3RRNOP/qkHniqjw3omsSyDJ0MVMmf/pCmRi9hONiFSKo
         CQQUNjTYWUaQQnQOHCAw0qUSJd1DmkVsqa73Uo8vQyC6wliazayzLyaoJ/JOci8Qv7Du
         dfQAiJl5OHzPA3H2riGlr8cYoaAdyLaXTCjkIJZnCFC3Zpj3P8tvOgc7NcwJ1H56KTS+
         u/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s6kvyFZCCfeghhHhKElYXyIn1aDbAYI4u2TzXLshK/o=;
        b=JyxK6hI6uRd2xPoRZ0cMmVAdl8/SnMzG1RNcG6te9AEQJL2Uraf4n6Arz/VQktJn9W
         RD9IQNDceQenD5jEA9pf/cvhrFPeujq4sVMQylJDIeP/KQ/v4vPwBVPcuFkBsf1fQkx+
         vThz+tzx9R1iO9ol5fKszLbmtuxxy9Yv31dSgBdNikOQpVon+p3r8/QU3J0w8rtTsJEu
         ox8gGa7i0hNhMLlW5NvevmlQdduqBjzpjb9oznHtNGB4r28QVaobHMAycubzyzf0+XLq
         T5w0QRNs3xRHaTR0PJ4Q03WVQiSXdre4jeAo0LCDawPdiCM8R42ic1WmNUPnv5aD+sIb
         iPyQ==
X-Gm-Message-State: AOAM533pzyZIb2SoS02n5e+igD6zRyft2bms2drecb10FkPUKSUvvx3I
        JDwib+ZD2q+LdiZNolsND55CgwjcNQlK87Il
X-Google-Smtp-Source: ABdhPJz6qNzVAJLdIjMtGe1NiM69P/xYP6NjFURMCtQy1NPKzDlndIt/xaCQfL5Kt/D7bOmrs3KxZQ==
X-Received: by 2002:ad4:56b1:: with SMTP id bd17mr3906501qvb.36.1603822173903;
        Tue, 27 Oct 2020 11:09:33 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z6sm1274263qtw.36.2020.10.27.11.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 11:09:32 -0700 (PDT)
Subject: Re: [PATCH RFC 1/7] block: export part_stat_read_all
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     linux-block@vger.kernel.org
References: <cover.1603751876.git.anand.jain@oracle.com>
 <047fe87c52b64caf1bd09eee4b1ca5130062a885.1603751876.git.anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <5c772e21-a401-1198-29d0-7ce0278b1544@toxicpanda.com>
Date:   Tue, 27 Oct 2020 14:09:32 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <047fe87c52b64caf1bd09eee4b1ca5130062a885.1603751876.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/26/20 7:55 PM, Anand Jain wrote:
> For mirrored raid profiles such as raid1, raid1c3, raid1c4, and raid10,
> currently, btrfs use the PID method to determine which one of the
> mirrored devices to use to read the block. However, the PID method is
> not the best choice if the devices are heterogeneous in terms of type,
> speed, and size, as we may end up reading from the slower device.
> 
> Export the function part_stat_read_all() so that the btrfs can determine
> the device with the least average wait time to use.
> 
> Cc: linux-block@vger.kernel.org
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

You don't need this, it can be accomplished with part_stat_read, or any variety 
of the helpers in part_stat.h.  Thanks,

Josef
